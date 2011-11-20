require 'spec_helper'

klass = Egi

describe klass, '.load environments:' do
  environments = <<-EOS
env(:env1) {
  item :a, { :hoge => :fuga }
  item :b, { :fuga => :ugu  }
}

env(:env2) {
  item :a, { :hoge => :ugu }
}
  EOS

  context "\n#{environments}" do
    before :all do
      described_class.load(environments)
    end
    after :all do
    end
    
    context 'makes env1' do
      subject { described_class[:env1] }
      
      its(:a) { should == { :name => :a, :hoge => :fuga } }
      its(:b) { should == { :name => :b, :fuga => :ugu  } }
    end

    context 'makes env2' do
      subject { described_class[:env2] }

      its(:a) { should == { :name => :a, :hoge => :ugu } }
      its(:b) { should be_nil }
    end

    context 'does not make env3' do
      subject { described_class[:env3] }
      it { should be_nil }
    end
  end
end