
#===================================================================================
# Created: 09/08/2017 Version: 0.5
# Autho: Boyan Syarov - https://github.com/ncracker
# File name: dd_metric_func.ps1
#
# Description: Submit a [float]value from localhost psobject to Datadog as a metric. 
# It defaults to namespace "ps1"
#
# Tested on Windows Server 2012 R2 w/ PSVersion 4.0
#
# Prerequisite: PowerShell ver.4.0+
#
# Refer to https://docs.datadoghq.com/api/#metrics for details
#===================================================================================

function unixTime() {
    Return (Get-Date -date ((get-date).ToUniversalTime()) -UFormat %s) -Replace("[,\.]\d*", "")
}

function postMetric($metric,$tags) {
    $currenttime = unixTime
    $host_name = $env:COMPUTERNAME #optional param
    # Construct JSON
    $points = ,@($currenttime, $metric.amount)
    $post_obj = [pscustomobject]@{"series" = ,@{"metric" = $metric.name;
                                                "points" = $points;
                                                "type" = "gauge";
                                                "host" = $host_name;
                                                "tags" = $tags}}
    $post_json = $post_obj | ConvertTo-Json -Depth 5 -Compress
    # POST to DD API
    $response = Invoke-RestMethod -Method Post -Uri $url -Body $post_json -ContentType "application/json" -Verbose
}

# Datadog account, API information and optional params
$app_key = "1234567890" #provide your valid app key
$api_key = "1234567890" #provide your valid api key
$url_base = "https://app.datadoghq.com/"
$url_signature = "api/v1/series"
$url = $url_base + $url_signature + "?api_key=$api_key" + "&" + "application_key=$app_key"
$tags = "[env:test]" #optional param

# Select what to send to DD
$metric_ns = "ps1."
$temp = Get-Process mmc
$metric = @{"name"=$metric_ns + $temp.Name; "amount"=$temp.Handles}
postMetric($metric)($tags)
