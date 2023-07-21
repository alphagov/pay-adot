import promClient from 'prom-client'
import express from 'express'

promClient.collectDefaultMetrics({ timeout: 10000 })
promClient.register.metrics().then(str => console.log('Metrics registered'))

function defaultLabels() {
  return {
    ecsClusterName: "local-test",
    ecsServiceName: "test-node-app",
    awsAccountName: "local",
  }
}

try {
  promClient.register.setDefaultLabels(defaultLabels());
} catch (ex) {
  const labels = {}
  console.log(`Failed to get labels ${ex}`)
}

const counters = {
  index: new promClient.Counter({
    name: 'page_count_index',
    help: 'Count of hits to the index page',
  }),
  foo: new promClient.Counter({
    name: 'page_count_foo',
    help: 'Count of hits to the foo page',
  }),
  metrics: new promClient.Counter({
    name: 'page_count_metrics',
    help: 'Count of hits to the metrics page',
  }),

}

const app = express()
const port = 3000

app.get('/', (req, res) => {
  counters.index.inc()
  console.log('GET /')
  res.send('Hello World!')
})

app.get('/foo', (req, res) => {
  counters.foo.inc()
  console.log('GET /foo')
  res.send('Foo woo hoo')
})

app.get('/metrics', async (req, res) =>  {
  counters.metrics.inc()
  console.log('GET /metrics')
  try {
    res.set('Content-Type', promClient.register.contentType)
    const metrics = await promClient.register.metrics()
    res.end(metrics)
  } catch (ex) {
    res.status(500).end(ex)
  }
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
