ios = (->
  checkConnection = ()->
    networkState = navigator.connection.type
    states = {}
    
    states[Connection.UNKNOWN]  = 'Unknown connection'
    states[Connection.ETHERNET] = 'Ethernet connection'
    states[Connection.WIFI]     = 'WiFi connection'
    states[Connection.CELL_2G]  = 'Cell 2G connection'
    states[Connection.CELL_3G]  = 'Cell 3G connection'
    states[Connection.CELL_4G]  = 'Cell 4G connection'
    states[Connection.CELL]     = 'Cell generic connection'
    states[Connection.NONE]     = 'No network connection'

    alert 'Connection type: ' + states[networkState]

  checkConnection()

  window.addEventListener 'batterystatus', onBatteryStatus, false

  onBatteryStatus = (info) ->
    alert 'Level: ' + info.level + ' isPlugged: ' + info.isPlugged 
)
`export default ios`