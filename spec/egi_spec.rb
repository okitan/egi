require 'spec_helper'

klass = Egi

RSpec::Matchers.define :have_item do |key, value|
  match do |actual|
    @actual   = actual.__send__(key)
    expected = { :name => key }.merge(value)
    @expected = [ expected ]

    @actual == expected
  end

  diffable
end

shared_examples_for :sample_environments do
  context 'makes env1' do
    subject { described_class[:env1] }
    
    it { should have_item(:a, :hoge => :fuga) }
    it { should have_item(:b, :fuga => :ugu)  }
  end
  
  context 'makes env_group' do
    subject { described_class[:env_group] }
    it { should have_item(:a, :hoge => :fuga, :tags => [ :hoge ]) }
    it { should have_item(:b, :tags => [ :hoge, :fuga ]) }
  end
  
  context 'makes env2' do
    subject { described_class[:env2] }
    
    it { should have_item(:a, :hoge => :ugu) }
    its(:b) { should be_nil }
  end

  context 'makes loaded_env1 which loads env1' do
    subject { described_class[:loaded_env1] }
    
    it { should have_item(:a, :hoge => :ugu) }
    it { should have_item(:b, :fuga => :ugu) }
  end
  
  context 'does not make env3' do
    subject { described_class[:env3] }
    it { should be_nil }
  end
end

describe klass, '.load environments:' do
  environments = <<-EOS
env(:env1) {
  item :a, { :hoge => :fuga }
  item :b, { :fuga => :ugu  }
}

env(:env_group) {
  group(:hoge) {
    item :a, { :hoge => :fuga }
    item :b, { :tags => [ :fuga ] }
  }
}
 
env(:env2) {
  item :a, { :hoge => :ugu }
}

env(:loaded_env1, :load => :env1) {
  item :a, { :hoge => :ugu }
}
  EOS

  context "\n#{environments}" do
    before(:all) { described_class.load(environments) }
    after(:all)  { described_class.reset }
    
    it_should_behave_like :sample_environments
  end
end

describe klass, '.load flat environments:' do
  environments = <<-EOS
env :env1
item :a, { :hoge => :fuga }
item :b, { :fuga => :ugu  }

env :env_group
group(:hoge) {
  item :a, { :hoge => :fuga }
  item :b, { :tags => [ :fuga ] }
}

env :env2
item :a, { :hoge => :ugu }

env :loaded_env1, :load => :env1
item :a, { :hoge => :ugu }
  EOS

  context "\n#{environments}" do
    before(:all) { described_class.load(environments) }
    after(:all)  { described_class.reset }
    
    it_should_behave_like :sample_environments
  end
end
