Deface::Override.new(:virtual_path  => "spree/layouts/spree_application",
                     :insert_before => "div.container",
                     :name          => "header1",
                     :partial => "spree/header")
                     
Deface::Override.new(:virtual_path  => "spree/layouts/spree_application",
                     :remove => "#header",
                     :name          => "header")