require 'test_helper'

class CertTest < ActiveSupport::TestCase

  setup do
    @sample = Cert.new
    @sample.set_random
    @sample.attach_zip
  end

  test "certs come with attachments" do
    assert @sample.has_attachment? "cert.zip"
  end

  test "cert.zipped returns zip attachment" do
    assert_equal "application/zip", @sample.zipped["content_type"]
  end

  test "cert.zipname returns name for the zip file" do
    assert_equal "cert.zip", @sample.zipname
  end

end
