-- Check if file exist and return true or false.
function file_exists(path)
  local path = path:gsub("^~", os.getenv("HOME"))
  local file = io.open(path, "r")
  return file ~= nil and io.close(file)
end
