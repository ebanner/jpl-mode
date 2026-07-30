; "{≢ ⍺ ↑ {:⍤1 ⍋⍨ (≢,⊃) ⌸⍨ ⍵}"
;
; {{ # x{. {: "1 \:~ (#,{.) /.~ y }}

(setq pairs
      '(("⍵" . "y")
        ("⍨" . "~")
        ("⌸" . "./")
        ("⊃" . "{.")
        ("≢" . "#")
        ("⍋" . "\\\\:")
        ("⍤" . "\"")
        ("↑" . "{.")
        ("{:" . "*tail*")
        ("{" . "{{")
        ("}" . "}}")
        ("⍺" . "x")
        ))

(setq apl-str "{≢ ⍺ ↑ {:⍤1 ⍋⍨ (≢,⊃) ⌸⍨ ⍵}")

(setq apl-str
 (let ((regexp (regexp-opt (mapcar #'car pairs))))
   (replace-regexp-in-string
    regexp
    (lambda (match)
      (pcase (assoc match pairs)
        (`(,_ . ,new) new)))
    apl-str)))

(setq pairs2
      '(("*tail*" . "{:")
        ))

(setq apl-str
 (let ((regexp (regexp-opt (mapcar #'car pairs2))))
   (replace-regexp-in-string
    regexp
    (lambda (match)
      (pcase (assoc match pairs2)
        (`(,_ . ,new) new)))
    apl-str)))

apl-str
