Deface::Override.new(:virtual_path  => "spree/checkout/_address",
                     :remove => "[data-hook='billing_fieldset_wrapper']",
                     :name          => "billing form remove")
                     
Deface::Override.new(:virtual_path  => "spree/checkout/_address",
                     :remove => "[data-hook='use_billing']",
                     :name          => "checkbox removed")

