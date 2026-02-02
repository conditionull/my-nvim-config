
### Status bar
<img width="617" height="64" alt="image" src="https://github.com/user-attachments/assets/260f1d42-059d-46ac-b055-5bdb404ed4cb" />

### Diagnostics & Inline Errors (Shift+K for hover window)
<details>
  <summary>Click to view diagnostic screenshots</summary>
<img width="616" height="436" alt="image" src="https://github.com/user-attachments/assets/379020c4-64ad-456c-9e67-e3a51e0ecacc" />
<img width="877" height="63" alt="image" src="https://github.com/user-attachments/assets/4730ebd3-110a-457d-80c7-17b8167fd534" />
<img width="874" height="143" alt="image" src="https://github.com/user-attachments/assets/f6be6095-5593-469c-9c5c-f95be105e06d" />
</details>

https://github.com/user-attachments/assets/fa405f32-cb68-42e2-83be-5f3009dc4f04

### Line wrapping
<img width="531" height="70" alt="image" src="https://github.com/user-attachments/assets/3ee05894-619e-4def-8d1e-ea863b8223ca" />

### Move current line or selection: Alt + Up/Down

https://github.com/user-attachments/assets/824b5df2-74b0-4d45-ba79-c063299ad949
> [!NOTE]
> Supported modes: Insert, Visual, Normal

### Select match -> replace all

https://github.com/user-attachments/assets/30229ddb-de66-4480-a92e-790afe71feb6
> [!NOTE]
> Press `Ctrl + n` until all matches are highlighted, then `d`, then `i`, and type to replace the completion matches. You can also use the standard vim motion but I find myself executing this quicker, possible skill issue. Docs here: https://github.com/mg979/vim-visual-multi

#### Git signs
<img width="450" height="178" alt="image" src="https://github.com/user-attachments/assets/a22f8772-6fc2-4f99-8feb-a9b2670283c7" />

#### Binds and other stuff
  
- `j` / `k` + arrow keys move by `visual lines` when lines are wrapped to avoid skips.

**Yanking**  
- Uses system clipboard (`unnamedplus`) when yanking
- `d,D` uses the **black hole register**, so a deletion doesn't overwrite clipboard content.

**Navigation**  
- `Shift + Up/Down` moves cursor **4 lines** at a time in `normal` and `insert` mode to hop around quickly

