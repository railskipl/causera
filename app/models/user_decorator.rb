Spree::User.class_eval do
      attr_accessible :email, :password, :password_confirmation,:fname,:lname,:zip,:phone,:address,:city,:state_id,:country_id
  end