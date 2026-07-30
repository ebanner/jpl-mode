; "{≢ ⍺ ↑ {:⍤1 ⍋⍨ (≢,⊃) ⌸⍨ ⍵}"
;
; {{ # x{. {: "1 \:~ (#,{.) /.~ y }}

(setq pairs
      '(("⍵" . " y ")
        ("⍨" . "~")
        ("⌸" . "/.")
        ("⊃" . "{.")
        ("≢" . "#")
        ("⍋" . "\\\\:")
        ("⍤" . "\"")
        ("↑" . "{.")
        ("{:" . "*tail*")
        ("}." . "*behead*")
        ("{" . "{{")
        ("}" . "}}")
        ("⍺" . "x")
        ("⊃" . "{.")
        ("∨" . "+.")
        ("×" . "*")
        ("⍳" . "i.")
        ))

(setq pairs2
      '(("*tail*" . "{:")
        ("*behead*" . "}.")
        ))

(defun apl->j (apl-str)

  (setq apl-str
        (let ((regexp (regexp-opt (mapcar #'car pairs))))
          (replace-regexp-in-string
           regexp
           (lambda (match)
             (pcase (assoc match pairs)
               (`(,_ . ,new) new)))
           apl-str)))

  (let ((regexp (regexp-opt (mapcar #'car pairs2))))
    (replace-regexp-in-string
     regexp
     (lambda (match)
       (pcase (assoc match pairs2)
         (`(,_ . ,new) new)))
     apl-str)))

(defun my-send-line-to-j ()
  (interactive)

  (let* ((text (string-trim
                (if (use-region-p)
                    (buffer-substring (region-beginning) (region-end))
                  (thing-at-point 'line t))))
         (apl-text (apl->j text))
         (win (get-buffer-window "*J*")))

    (message apl-text)

    (with-current-buffer (get-buffer "*J*")
      (goto-char (point-max))
      (insert apl-text)
      (comint-send-input))

    (when win
      (set-window-point win (with-current-buffer "*J*" (point-max))))))

(global-set-key (kbd "TAB") #'my-send-line-to-j)
