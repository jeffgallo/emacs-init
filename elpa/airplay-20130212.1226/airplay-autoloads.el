;;; airplay-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "airplay" "airplay.el" (0 0 0 0))
;;; Generated autoloads from airplay.el

(autoload 'airplay/image:view "airplay" "\


\(fn IMAGE_FILE &optional TRANSITION)" nil nil)

(autoload 'airplay:stop "airplay" "\


\(fn)" t nil)

(autoload 'airplay/video:play "airplay" "\


\(fn VIDEO_LOCATION)" nil nil)

(autoload 'airplay/video:scrub "airplay" "\
Retrieve the current playback position.

\(fn &optional CB)" nil nil)

(autoload 'airplay/video:seek "airplay" "\


\(fn POSITION)" nil nil)

(autoload 'airplay/video:info "airplay" "\


\(fn &optional CALLBACK)" nil nil)

(autoload 'airplay/video:pause "airplay" "\


\(fn)" t nil)

(autoload 'airplay/video:resume "airplay" "\


\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "airplay" '("airplay")))

;;;***

;;;### (autoloads nil "airplay-video-server" "airplay-video-server.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from airplay-video-server.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "airplay-video-server" '("airplay/server:")))

;;;***

;;;### (autoloads nil nil ("airplay-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; airplay-autoloads.el ends here
