function file_exists(name)
  local name = name:gsub('^~', os.getenv('HOME'))
  local file = io.open(name, 'r')
  return file ~= nil and io.close(file)
end
