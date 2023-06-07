(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Load shell environment variables
(use-package exec-path-from-shell
  :init
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package counsel)
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
(use-package counsel-projectile
  :config
  (counsel-projectile-mode))

(use-package pyvenv
  :config
  (setq pyvenv-activate nil)
  (setenv "WORKON_HOME" "~/.virtualenvs") ;; Change this to your virtualenvs directory
  (pyvenv-mode 1))

(use-package lsp-mode
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package lsp-python-ms
  :init
  (setq lsp-python-ms-executable
        "~/lsp-python-ms/languageServer/.venv/bin/MicrosoftPythonLanguageServer") ;; Ensure that you have correct path of MicrosoftPythonLanguageServer executable
  :hook
  (python-mode . (lambda ()
                   (require 'lsp-python-ms)
                   (lsp))))

(use-package flycheck
  :init
  (global-flycheck-mode))

(use-package flycheck-flake8)

(defun setup-python-flake8 ()
  (setq-local flycheck-checker 'python-flake8)
  (flycheck-mode 1))
(add-hook 'python-mode-hook 'setup-python-flake8)
