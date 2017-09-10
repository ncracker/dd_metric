# Sending metrics to Datadog
Submit metrics to Datadog with PowerShell using native PS constructs.
Examples for both Datadog Metrics API and dogstatsd are provided.

### dd_metric_api.ps1
Basic example, which submits a metric in the "ps1" namespace via Datadog API.
dd-agent isn't necessary as the metric is submitted via HTTP POST directly to the API.

### dd_metric_func_api.ps1
Basic example, which submits a metric in the "ps1" namespace via Datadog API.
Broken down with a couple of functions, making it easier to reuse in bigger projects.
dd-agent isn't necessary as the metric is submitted via HTTP POST directly to the API.

### dd_metric_dogstatsd.ps1
Basic example, which submits a metric via dogstatsd. This would require installed & running dd-agent.
No need to specify API key as that's provided by the agent.

See https://docs.datadoghq.com/api/ for details.
