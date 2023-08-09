name = "email-communication/email-sending"
version = "0.0.0"

"Sends an email to specified recipients with optional Bcc, Cc, and reply-to addresses, as well as HTML and plain text versions of the message."
usecase SendEmail unsafe  {
  input {
    "Recipient email address. Multiple addresses are comma separated. Max 50."
    to! string!
  
    "Sender email address. To include a friendly name, use the format 'Your Name <sender@domain.com>'."
    from! string!
  
    "Email subject."
    subject! string!
  
    "Bcc recipient email address. Multiple addresses are comma separated. Max 50."
    bcc string!
  
    "Cc recipient email address. Multiple addresses are comma separated. Max 50."
    cc string!
  
    "Reply-to email address."
    reply_to string!
  
    "The HTML version of the message."
    html string!
  
    "The plain text version of the message."
    text string!
  }
  result {
    id! string!
  
    from! string!
  
    to! string!
  
    created_at! string!
  }!
  error {
    error! {
      "Error code representing the type of error."
      code! number!
    
      "A human-readable description of the error."
      message! string!
    
      "Additional information about the error, if available."
      details! {
        "The email address that caused the error."
        invalid_email! string!
      }
    }!
  }!
  example InputExample {
    input {
      to = 'recipient@example.com',
      from = 'Your Name <sender@example.com>',
      subject = 'Hello, World!',
      bcc = 'bcc@example.com',
      cc = 'cc@example.com',
      reply_to = 'reply@example.com',
      html = '<p>Hello, World!</p>',
      text = 'Hello, World!',
    }
    result {
      id = 'placeholder',
      from = 'placeholder',
      to = 'placeholder',
      created_at = 'placeholder',
    }
  }
}

