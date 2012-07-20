Deface::Override.new(:virtual_path  => "spree/layouts/spree_application",
                     :insert_before => "div#wrapper",
                     :name          => "wrap",
                     :partial => "spree/wrap")
                     
