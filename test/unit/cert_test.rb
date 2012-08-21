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

  test "test data is valid" do
    assert @sample.valid?
  end

  test "validates random" do
    [0, 1, nil, "asdf"].each do |invalid|
      @sample.random = invalid
      assert !@sample.valid?, "#{invalid} should not be a valid value for random"
    end
  end

  test "validates attachment" do
    @sample.delete_attachment(@sample.zipname)
    assert !@sample.valid?, "Cert should require zipped attachment"
  end

end
