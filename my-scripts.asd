#-asdf3.1 (error "ASDF 3.1 or bust!")

(defsystem "my-scripts"
    :version "0.1.0"
    :description "CL scripts"
    :license "MIT"
    :author "innaky"
    :class :package-inferred-system
    :depends-on ((:version "cl-scripting" "0.1")
		 (:version "inferior-shell" "2.0.3.3")
		 (:version "fare-utils" "1.0.0.5")
		 (:version "md5" "2.0.4")
		 "my-scripts/main"
		 "my-scripts/apps"))
