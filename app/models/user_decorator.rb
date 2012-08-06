Spree::User.class_eval do
      attr_accessible :email, :password, :password_confirmation,:address
  end