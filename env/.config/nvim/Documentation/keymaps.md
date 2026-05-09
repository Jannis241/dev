# Keymaps

`<leader>` ist Space.

## Navigation und Dateien

| Key | Mode | Aktion |
| --- | --- | --- |
| `\` | Normal | `Neotree reveal`, oeffnet Neo-tree auf aktueller Datei |
| `<leader>pv` | Normal | Neo-tree oeffnen |
| `<leader>ppv` | Normal | `:Ex` oeffnen |
| `<leader>pf` | Normal | Telescope Find Files |
| `<leader>ps` | Normal | Telescope Live Grep |
| `<leader>pws` | Normal | Telescope Suche im aktuellen Buffer |
| `<leader>fb` | Normal | Telescope Buffer-Auswahl |
| `<leader>fh` | Normal | Telescope Help Tags |

## Theme

| Key | Mode | Aktion |
| --- | --- | --- |
| `<C-t>` | Normal | Theme-Auswahl oeffnen |

Alternativ geht auch `:Theme`.

## LSP

Diese Keymaps werden nur gesetzt, wenn ein LSP am Buffer haengt.

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>gd` | Normal | Go to Definition |
| `<leader>gb` | Normal | Zurueck zur vorherigen Jump-Position (`<C-o>`) |
| `<leader>gf` | Normal | Vorwaerts in der Jump-History (`<C-i>`) |
| `K` | Normal | Hover-Dokumentation mit rounded Border |
| `<C-k>` | Normal | Hover-Dokumentation mit rounded Border |
| `<leader>vws` | Normal | Workspace Symbol suchen |
| `<leader>e` | Normal | Diagnostic-Float an Cursorposition oeffnen, ohne den Fokus zu stehlen |
| `<leader>vca` | Normal | Code Action |
| `<leader>fr` | Normal | References anzeigen |
| `<leader>rn` | Normal | LSP Rename |
| `<C-h>` | Insert/Normal | Signature Help |

## Errors und Quickfix

`<leader>e` bleibt bewusst ein einzelnes Mapping. Die Trouble-Uebersichten liegen unter `<leader>x...`, damit Neovim nach `<leader>e` nicht auf weitere Tasten wartet.

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>xf` | Normal | Alle Errors im aktuellen File in Trouble anzeigen, ohne Trouble zu fokussieren |
| `<leader>xp` | Normal | Alle Errors im Projekt in Trouble anzeigen, ohne Trouble zu fokussieren |
| `<leader>qf` | Normal | Quickfix-Liste in Trouble anzeigen |
| `]q` | Normal | Naechster Quickfix-Eintrag und zentrieren |
| `[q` | Normal | Vorheriger Quickfix-Eintrag und zentrieren |
| `<leader>k` | Normal | Naechster Location-List-Eintrag und zentrieren |
| `<leader>j` | Normal | Vorheriger Location-List-Eintrag und zentrieren |

In Trouble kannst du mit `j`/`k` navigieren. `Enter` springt zum ausgewaehlten Error und schliesst Trouble. Trouble laeuft jetzt ohne Fokuswechsel, damit du im Editor bleiben kannst.

## Completion

Diese Mappings gelten im Completion-Menue von `nvim-cmp`.

| Key | Mode | Aktion |
| --- | --- | --- |
| `<C-j>` | Insert | Naechster Completion-Eintrag |
| `<C-k>` | Insert | Vorheriger Completion-Eintrag |
| `<Tab>` | Insert | Completion bestaetigen |
| `<Enter>` | Insert | Completion bestaetigen |
| `<C-Space>` | Insert | Completion manuell oeffnen |

Die Completion-Vorschlaege und die Dokumentation erscheinen jeweils in bordered Float-Fenstern. Die Completion-Box ist breiter als frueher, damit Eintraege lesbar bleiben, und die Dokumentation hat ebenfalls mehr Platz. Hover- und Signature-Help-Floats folgen demselben Stil.

## Formatierung

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>f` | Normal | Aktuellen Buffer mit Conform formatieren |

Rust, Python und Java werden zusaetzlich automatisch beim Speichern formatiert.

## Git

### Fugitive

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>gs` | Normal | `:Git` oeffnen |
| `gu` | Normal | In Diff/Merge `diffget //2` |
| `gh` | Normal | In Diff/Merge `diffget //3` |

Nur in Fugitive-Buffern:

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>p` | Normal | `Git push` |
| `<leader>P` | Normal | `Git pull --rebase` |
| `<leader>t` | Normal | `Git push -u origin ` vorbereiten |

### Gitsigns

| Key | Mode | Aktion |
| --- | --- | --- |
| `]h` | Normal | Naechster Git-Hunk |
| `[h` | Normal | Vorheriger Git-Hunk |
| `<leader>hs` | Normal/Visual | Hunk oder Auswahl stagen |
| `<leader>hr` | Normal/Visual | Hunk oder Auswahl resetten |
| `<leader>hp` | Normal | Hunk preview |
| `<leader>hb` | Normal | Blame fuer aktuelle Zeile |
| `<leader>hB` | Normal | Line-Blame togglen |
| `<leader>hd` | Normal | Diff fuer aktuelle Datei |

## Rust

Nur in Rust-Buffern:

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>ra` | Normal | Rust hover actions |
| `<leader>rd` | Normal | Rust Diagnostic rendern |
| `<leader>od` | Normal | Rust Docs oeffnen |

## Todo Comments

Todo-Navigation nutzt bracket-style Mappings. Es gibt bewusst kein `pt`/`nt`, weil `pt` normales `p` verzoegern wuerde.

| Key | Mode | Aktion |
| --- | --- | --- |
| `]T` | Normal | Naechster Todo-Kommentar |
| `[T` | Normal | Vorheriger Todo-Kommentar |
| `<leader>ft` | Normal | Todos in Telescope suchen |
| `<leader>xt` | Normal | Todos in Trouble anzeigen |

## Snippets

| Key | Mode | Aktion |
| --- | --- | --- |
| `<C-s>e` | Insert | Snippet expandieren |
| `<C-s>;` | Insert/Select | Zum naechsten Snippet-Jump |
| `<C-s>,` | Insert/Select | Zum vorherigen Snippet-Jump |
| `<C-E>` | Insert/Select | Naechste Snippet-Choice |

## Harpoon

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>ma` | Normal | Aktuelle Datei zu Harpoon hinzufuegen |
| `<leader>mm` | Normal | Harpoon-Menue oeffnen/schliessen |
| `<leader>1` | Normal | Zu Harpoon-Datei 1 springen |
| `<leader>2` | Normal | Zu Harpoon-Datei 2 springen |
| `<leader>3` | Normal | Zu Harpoon-Datei 3 springen |
| `<leader>4` | Normal | Zu Harpoon-Datei 4 springen |
| `<leader>mn` | Normal | Naechste Harpoon-Datei |
| `<leader>mp` | Normal | Vorherige Harpoon-Datei |

## Allgemein

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>q` | Normal | Quickfix-Fenster schliessen (`:cclose`) |
| `<C-y>` | Normal/Visual | In System-Clipboard kopieren |
| `<C-a>` | Normal/Visual/Insert | Gesamten Buffer selektieren |
| `<` | Visual | Ausruecken und Auswahl behalten |
| `>` | Visual | Einruecken und Auswahl behalten |
| `<C-d>` | Normal | Halbseite runter und zentrieren |
| `<C-u>` | Normal | Halbseite hoch und zentrieren |
| `<leader>d` | Normal/Visual | Loeschen ohne Yank-Register zu ueberschreiben |
| `<leader><leader>` | Normal | Aktuelle Datei sourcen |
| `<leader>u` | Normal | Undotree togglen |
