Deface::Override.new(:virtual_path  => "spree/checkout/_address",
                     :remove => "[data-hook='use_billing']",
                     :name          => "checkbox removed")
Deface::Override.new(:virtual_path  => "spree/checkout/edit",
                     :remove => "#checkout-summary",
                     :name          => "order summary removed")


Deface::Override.new(:virtual_path  => "spree/checkout/edit",
                     :remove => "[data-hook='checkout_header']",
                     :name          => "header removed")