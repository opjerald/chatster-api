if @message.save
  json.success 1 == 1
  json.message "Message successfully send"
  json.data @message
else
  json.success 1 == 2
  json.message "Message failed to send"
  json.errors @message.errors.full_messages
end