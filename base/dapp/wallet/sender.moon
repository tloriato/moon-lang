labeledInput = zb2rhf794zX7t2icn24oKfpmYAsLz6xrUGQNac2KHbRYe7Q6K
do = zb2rhkLJtRQwHz9e5GjiQkBtjL2SzZZByogr1uNZFyzJGA9dX
tokenTransfer = zb2rhkP5QB1w9MKsNvGUX6C5BZYEtevV3ZFf1a2peknBfGg1b
arrayJoin = zb2rhgWm1GQM8ith9EBVJSMxsLAZBzGGsCvgnyaPZHmz3c7ym

{
  name: "wallet-sender"
  args: {
    token: "ETH"
    linkColor: "rgb(74,139,217)"
  }
  state: {
    to: "0x"
    amount: 0
  }
  value: my =>
    size = (my "size")
    w = (get size "0")
    h = (get size "1")
    sendToBox = {
      name: "send-to"
      pos: [0 0]
      size: [w 64]
      onHear: to =>
        newState = {
          to: to
          amount: (my "amount")
        }
        (do "set" newState)>
        (do "end")
      set: {
        label: "SEND TO"
        type: "address"
      }
      value: labeledInput
    }
    amountBox = {
      name: "amount"
      pos: [0 96]
      size: [w 64]
      onHear: amount =>
        newState = {
          to: (my "to")
          amount: (stn amount)
        }
        (do "set" newState)>
        (do "stop")
      set: {
        label: "AMOUNT"
        type: "number"
      }
      value: labeledInput
    }
    send = {
      pos: [0 192]
      size: [w 24]
      cursor: "pointer"
      onClick:
        to = (my "to")
        amount = (my "amount")
        token = (my "token")
        result = <(tokenTransfer to amount token)
        (do "yell" result)>
        (do "stop")
      font: {
        weight: "bold"
        family: "helvetica"
        color: (my "linkColor")
      }
      value: 
        amount = (my "amount")
        (arrayJoin " " ["SEND" amount (my "token")])
    }
    cancel = {
      pos: [0 240]
      size: [w 20]
      cursor: "pointer"
      font: {
        family:"helvetica"
        color: (my "linkColor")
      }
      onClick: |
        (do "yell" {type: "cancel"})>
        (do "stop")
      value: "Cancel"
    }

    [
      sendToBox
      amountBox
      send
      cancel
    ]

}
