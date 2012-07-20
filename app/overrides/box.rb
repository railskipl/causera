Deface::Override.new(:virtual_path  => "spree/layouts/spree_application",
                     :replace => "aside#sidebar",
                     :name          => "box1",
                     :partial => "spree/box")
                     
Deface::Override.new(:virtual_path  => "spree/layouts/spree_application",
                     :insert_before => "div#content",
                     :name          => "box2",
                     :partial => "spree/right")
                     
