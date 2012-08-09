Spree::Order.class_eval do
  token_resource

  # Associates the specified user with the order and destroys any previous association with guest user if
  # necessary.tateMachine::Machine.ignore_method_conflicts = true 
  Spree::Order.state_machines.clear 

  state_machine :initial => 'cart', :use_transactions => false do 

    event :next do 
        transition :from => 'cart',     :to => 'address'
        transition :from => 'address',  :to => 'payment', :if => :payment_required?
        transition :from => 'delivery', :to => 'complete'
        transition :from => 'confirm',  :to => 'complete'

      # note: some payment methods will not support a confirm step 
      transition :from => 'payment',  :to => 'confirm', 
                                      :if => Proc.new { |order| order.payment_method && order.payment_method.payment_profiles_supported? } 

      transition :from => 'payment', :to => 'complete' 
    end 

    event :cancel do 
      transition :to => 'canceled', :if => :allow_cancel? 
    end 
    event :return do 
      transition :to => 'returned', :from => 'awaiting_return' 
    end 
    event :resume do 
      transition :to => 'resumed', :from => 'canceled', :if => :allow_resume? 
    end 
    event :authorize_return do 
      transition :to => 'awaiting_return' 
    end 

    before_transition :to => 'complete' do |order| 
      begin 
        order.process_payments! 
      rescue Core::GatewayError 
        if Spree::Config[:allow_checkout_on_gateway_error] 
          true 
        else 
          false 
        end 
      end 
    end 

    before_transition :to => ['delivery'] do |order| 
      order.shipments.each { |s| s.destroy unless s.shipping_method.available_to_order?(order) } 
    end 

    after_transition :to => 'complete', :do => :finalize! 
    after_transition :to => 'delivery', :do => :create_tax_charge! 
    after_transition :to => 'payment',  :do => :create_shipment! 
    after_transition :to => 'resumed',  :do => :after_resume 
    after_transition :to => 'canceled', :do => :after_cancel 

  end 


  def associate_user!(user)
    self.user = user
    self.email = user.email
    # disable validations since this can cause issues when associating an incomplete address during the address step
    save(:validate => false)
  end
  
  private
        def set_default_shipping_method
          self.update_attribute(:shipping_method_id, 0)
          order.update_totals!
          reload
        end
end
