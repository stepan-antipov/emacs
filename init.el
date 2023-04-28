;;
;;
;;
;;      ***                                                              ***
;;      **    #####                                                        **
;;     **        ###                                                       **.
;;     **        ####      ////// /////    //////     //////    //////     ***
;;     **       ######     ///  ///  //*  ///   //   ///  ///  ///  ///    ***
;;     ***     ###  ##     //   ///  ///    ///////  //   //    ////       ***
;;      **    ###   ####   //   //*  /// ///    ///  //    /// //   ////   **
;;      ***  ###      ##   //        ///   ,///////    ////      /////   .**
;;
;;
;;
;;; Code:





;; загрузка текуущего файла
;;(load "./proced.el")

;; load logo.
(find-file-read-only
 (expand-file-name "assets/lambdamacs.txt" user-emacs-directory))

;;
;; Initialize package sources
;;проверяет, загружены ли пакеты. Если нет,  загружает их.' - означает название
;;переменной
(require 'package)
(setq package-user-dir (expand-file-name "packages" user-emacs-directory))
(unless (file-exists-p package-user-dir)
    (make-directory package-user-dir))

;; Always load newest byte code
;;Загружает более новые версии файлов, если они есть?
(setq load-prefer-newer t)

(setq package-archives
      '(("melpa-stable" . "https//stable.melpa.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("org"   . "https://orgmode.org/elpa/")
        ("elpa"  . "https://elpa.gnu.org/packages/")
        ))

;;unless - Приведение готовности к использованию пакетов
;; Если выражение ложно, выполняем следующий код
(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;;
;;  Initialize use-package on non-Linux platforms
;;закомментировал, так как linux
;;(unless (package-installed-p 'use-package)
;;  (package-install 'use-package))









;; add use pacakge and set gloabl `:ensure t`
;;устанавливает пакеты,автоматически, если они не установлены
(require 'use-package)
(setq use-package-always-ensure t)



;; add-to-list -добавить в конец списка
;; load-path -переменная, в которой лежит список директорий, которые нужно
;; запустить по команде require или load
(setq lambdamacs-dir         (expand-file-name "src" user-emacs-directory))
(setq lambdamacs-conf-dir    (expand-file-name "config" user-emacs-directory))
(setq lambdamacs-modules-dir (expand-file-name "modules" user-emacs-directory))
(add-to-list 'load-path lambdamacs-dir)
(add-to-list 'load-path lambdamacs-conf-dir)
(add-to-list 'load-path lambdamacs-modules-dir)

(setq custom-file (expand-file-name "emacs-custom.el" lambdamacs-conf-dir))

;;if - если выражение истинно, выполняем код
(defun loadx (file)
  "load a configuration file if it exists."
  (if (file-exists-p (expand-file-name file lambdamacs-conf-dir))
      (load-file (expand-file-name file lambdamacs-conf-dir))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;последовательно подгружаются файлы
(load  "user-config.el")    ;; Load user preferences
(loadx "custom-config.el")  ;; load custom configuration if present
(load  "look-n-feel.el")    ;; visual aspects
(load  "editor.el")         ;; editor settings
(load  "general.el")        ;; general settings
(load  "dev.el")            ;; common dev tools
(load  "dev-clojure.el")    ;; clojure settings
(load  "dev-java.el")       ;; settings for java development
(load  "productivity.el")   ;; org-mode and productivity tools
(loadx "emacs-custom.el")   ;; load emacs customizations
(loadx "post-init.el")      ;; load custom post configuration if present


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;;                     ----==| R E C O M P I L E |==----                      ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Установка gnu-elpa-keyring-update и присваиваем значение переменной на nil
;;(let ((package-check-signature nil))
;;   (package-install 'gnu-elpa-keyring-update))


;;
;; recompile all if not compiled
;;
;;(if (not (file-exists-p (concat buffer-file-name "c")))
;;    (byte-compile-all-init-dir))

;;added Stepan Antipov 04.04.2023
;; '() - чтение кода как строки
;;(require 'package)
;;(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
;;("gnu" . "http://elpa.gnu.org/packages/")
;;("marmalade" . "http://marmalade-repo.org/packages/")))

                                        ; Apparently needed for the package auto-complete (why?)
;;(add-to-list 'package-archives
;;'("melpa" . "http://melpa.org/packages/") t)

;;(package-initialize)
;;(setq url-http-attempt-keepalives nil)

;;(when (not package-archive-contents)
;;(package-refresh-contents))

;;; init.el ends here
