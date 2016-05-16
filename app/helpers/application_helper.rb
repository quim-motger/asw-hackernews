require 'base64'

module ApplicationHelper

  ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  ENCODING = "MOhqm0PnycUZeLdK8YvDCgNfb7FJtiHT52BrxoAkas9RWlXpEujSGI64VzQ31w"

  def encode(text)
    Base64.strict_encode64(text)
    # text.tr(ALPHABET, ENCODING)
  end

  def decode(text)
    Base64.strict_decode64(text)
    # text.tr(ENCODING, ALPHABET)
  end

  def signin_path(provider)
    "/auth/#{provider.to_s}"
  end
end
