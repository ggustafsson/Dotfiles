-------------------------------------------------------------------------------
-- Automatically change the volume when home network is not available.
-------------------------------------------------------------------------------
local wifiWatcher = nil
local homeSSID = "Alderaan"
local lastSSID = hs.wifi.currentNetwork()

function ssidChanged()
  newSSID = hs.wifi.currentNetwork()

  if newSSID == homeSSID and lastSSID ~= homeSSID then
    hs.audiodevice.defaultOutputDevice():setVolume(43)
  elseif newSSID ~= homeSSID and lastSSID == homeSSID then
    hs.audiodevice.defaultOutputDevice():setVolume(0)
  end

  lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChanged)
wifiWatcher:start()
