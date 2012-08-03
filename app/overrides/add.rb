Deface::Override.new(:virtual_path  => "spree/checkout/_address",
                     :remove => "[data-hook='use_billing']",
                     :name          => "checkbox removed")



Deface::Override.new(:virtual_path  => "spree/checkout/edit",
                     :remove => "[data-hook='checkout_header']",
                     :name          => "header removed")


Deface::Override.new(:virtual_path  => "spree/checkout/edit",
                     :remove =>   "[data-hook='checkout_summary_box']",
                     :name          => "order summary")                     