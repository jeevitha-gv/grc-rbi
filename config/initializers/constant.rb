ALLMESSAGES = YAML.load_file("#{Rails.root.to_s}/config/locales/messages.yml")
MESSAGES =  ALLMESSAGES["en"]
