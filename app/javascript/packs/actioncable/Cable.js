import ActionCable from 'actioncable'

const getConsumerUrl = () => {
  const elements = document.getElementsByName('action-cable-url')

  if (elements.length !== 1) throw 'ActionCable could not be initialized.'

  return elements[0].getAttribute('content')
}

const Cable = ActionCable.createConsumer(getConsumerUrl())

export default Cable
