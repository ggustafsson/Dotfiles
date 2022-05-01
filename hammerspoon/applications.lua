---------------------------
-- Key v: Execute clippy --
---------------------------
hs.hotkey.bind(preKeys, "v", function()
  hs.open(os.getenv("HOME") .. "/Scripts/clippy")
end)
