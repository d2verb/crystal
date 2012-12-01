require 'spec_helper'

describe 'Type inference: pointer' do
  it "types int pointer" do
    assert_type('a = 1; ptr(a)') { PointerType.of(int) }
  end

  it "types pointer value" do
    assert_type('a = 1; b = ptr(a); b.value') { int }
  end

  it "types pointer set value" do
    assert_type(%q(
      class Foo
        def foo
          p = ptr(@value)
          p.value = 1
        end
        def value
          @value
        end
      end

      f = Foo.new
      f.foo
      f.value)) { int }
  end
end