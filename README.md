# jpl-mode

APL/BQN glyphic frontend for J

## Examples

Fixed point scan

```apl
{⍵÷2} ⍣ ⍬ ⊢ 55
```

Power scan with condition

```apl
{⍵÷2} ⍣ {⍵≥1} ⍣ ⍬ ⊢ 10
```

Amend

```apl
1 (<1 1) ⊙ 3 3⍴0
```

Stencil (no padding)

```apl
2 2 < ⌺ ¯3 ⊢ 3 3⍴0
```

Counts

```apl
(↑,≢) ⌸⍨ 1 2 1 2 1
```

Inverse/obverse
```apl
str ← '24:00'

serde ← ((60∘⊥) ⍤ ((⍎¨)⇔(⍕¨)) ⍤ ((':'∘cut)⇔(':'∘joinstring))) NB. chopstring also works

3 {÷∘⍺⍢serde⍵} str
```
