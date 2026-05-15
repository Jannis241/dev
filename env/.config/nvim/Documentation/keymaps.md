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
| `<leader>e` | Normal | Error-Float fuer die aktuelle Zeile oeffnen, ohne den Fokus zu stehlen |
| `<leader>vca` | Normal | Code Action |
| `<leader>fr` | Normal | References anzeigen |
| `<leader>rn` | Normal | LSP Rename |
| `<C-h>` | Insert/Normal | Signature Help |

## Errors und Quickfix

`<leader>e` zeigt den Error-Float fuer die aktuelle Zeile und ist kein Prefix, damit der Float ohne Mapping-Timeout aufgeht. Die Trouble-Uebersichten liegen unter `<leader>fe` und `<leader>pe`.

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>fe` | Normal | Alle Errors im aktuellen File in Trouble anzeigen und Trouble fokussieren |
| `<leader>pe` | Normal | Alle Errors im Projekt in Trouble anzeigen und Trouble fokussieren |
| `<leader>qf` | Normal | Quickfix-Liste in Trouble anzeigen |
| `]q` | Normal | Naechster Quickfix-Eintrag und zentrieren |
| `[q` | Normal | Vorheriger Quickfix-Eintrag und zentrieren |
| `<leader>k` | Normal | Naechster Location-List-Eintrag und zentrieren |
| `<leader>j` | Normal | Vorheriger Location-List-Eintrag und zentrieren |

In Trouble kannst du mit `j`/`k` durch die Error-Eintraege gehen. Die Code-Preview springt dabei jeweils zur passenden Stelle. `Enter` springt final zum ausgewaehlten Error und schliesst Trouble.

## Completion

Diese Mappings gelten im Completion-Menue von `nvim-cmp`.

| Key | Mode | Aktion |
| --- | --- | --- |
| `<C-j>` | Insert | Naechster Completion-Eintrag |
| `<C-k>` | Insert | Vorheriger Completion-Eintrag |
| `<Tab>` | Insert | Completion bestaetigen |
| `<Enter>` | Insert | Completion bestaetigen |
| `<C-Space>` | Insert | Completion manuell oeffnen |
| `<C-f>` | Insert | Completion-Dokumentation nach unten scrollen |
| `<C-b>` | Insert | Completion-Dokumentation nach oben scrollen |

Die Completion-Vorschlaege und die Dokumentation erscheinen jeweils in bordered Float-Fenstern mit transparentem Hintergrund. Die Dokumentation ist seitlich neben der Completion konfiguriert und die Completion liegt im Z-Index ueber der Dokumentation, damit die Auswahl nicht von Docs verdeckt wird. Die Dokumentation kann mit `<C-f>`/`<C-b>` gescrollt werden.

## Formatierung

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>f` | Normal | Aktuellen Buffer mit Conform formatieren |

Rust, Python und Java werden zusaetzlich automatisch beim Speichern formatiert.

## Linting

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>ll` | Normal | Aktuellen Buffer mit nvim-lint linten |

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

Todo-Kommentare erkennen `TODO`, `Todo` und `todo`. Der Doppelpunkt ist optional, also werden sowohl `todo:` als auch `todo` erkannt.

| Key | Mode | Aktion |
| --- | --- | --- |
| `<leader>nt` | Normal | Naechster Todo-Kommentar |
| `<leader>pt` | Normal | Vorheriger Todo-Kommentar |
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
