#===================================================================================
# Created: 09/10/2017 Version: 0.4
# Author: Boyan Syarov - https://github.com/ncracker
# File name: dd_metric_dogstatsd.ps1
#
# Description: Submit a [float]value via dogstatsd, which is built into the dd-agent
# It works with statsd as well.
#
# Tested on Windows Server 2012 R2 w/ PSVersion 4.0
#           Windows Server 2008 x64 R2 w/ PSVersion 2.0
#
# Prerequisite: PowerShell ver.2.0+
#
# Refer to https://docs.datadoghq.com/api/#metrics for details
#===================================================================================

$udpClient = New-Object System.Net.Sockets.UdpClient
$udpClient.Connect('127.0.0.1', '8125')
$encodedData=[System.Text.Encoding]::ASCII.GetBytes("my_metric:123|g")
$bytesSent=$udpClient.Send($encodedData,$encodedData.Length)
