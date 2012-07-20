Deface::Override.new(:virtual_path  => "spree/layouts/spree_application",
                     :replace => "#footer",
                     :name          => "footer",
                     :partial => "spree/footer")