class EventHandler {
  constructor (controller) {
    this.eventHandlers = []
    this.identifier = controller.scope.identifier

    const controllerDisconnectCallback = controller.disconnect.bind(controller)

    Object.assign(controller, {
      handleEvent: this.handleEvent,
      removeHandledEvents: this.removeHandledEvents,
      disconnect () {
        controllerDisconnectCallback()
        this.removeHandledEvents()
      }
    })
  }

  // if options.delegation is true, the event will be delegated to the child element
  // that has the data-delegated-action attribute with the value
  // `${type}->${identifier}#${callback.name}`
  // and child elements with the data-prevent-delegation attribute will not be delegated to
  // e.g. data-delegated-action="click->my_controller#my_action"
  //      data-prevent-delegation="true"
  // otherwise, the event will be handled by the element that the event is attached to.
  handleEvent = (type, options = {}) => {
    const element = options.on || document
    const isDelegation = options.delegation
    const callback = options.with
    const identifier = this.identifier

    const handler = {
      listener (event) {
        if (isDelegation) {
          if (event.target.dataset.preventDelegation) { return }

          const targetSelector = `[data-delegated-action~='${type}->${identifier}#${callback.name}']`
          const target = event.target.closest(targetSelector)

          if (!target) { return }

          callback(event, target)
          return;
        }

        callback(event)
      },

      removeListener () {
        element.removeEventListener(type, this.listener)
      }
    }

    element.addEventListener(type, handler.listener)

    this.eventHandlers.push(handler)
  }

  removeHandledEvents = () => {
    this.eventHandlers.forEach((handler) => handler.removeListener())
    this.eventHandlers = []
  }
}

export const installEventHandler = (controller) => {
  return new EventHandler(controller)
}
