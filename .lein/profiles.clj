{:user {:plugins [[lein-kibit "0.0.8"]
                  [lein-cljsbuild "0.3.4"]
                  [jonase/eastwood "0.0.2"]
                  [lein-ancient "0.5.3"]
                  [cider/cider-nrepl "0.6.0"]]
         :repl {:repl-options {:init (use 'clojure.repl)}}}}
