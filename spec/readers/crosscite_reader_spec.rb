# frozen_string_literal: true

require 'spec_helper'

describe Briard::Metadata, vcr: true do
  subject { described_class.new(input: input) }

  let(:input) { "#{fixture_path}crosscite.json" }

  context 'get crosscite raw' do
    it 'SoftwareSourceCode' do
      expect(subject.raw).to eq(File.read(input).strip)
    end
  end

  context 'get crosscite metadata' do
    it 'SoftwareSourceCode' do
      expect(subject.valid?).to be true
      expect(subject.identifiers).to eq([
                                          { 'Identifier' => 'https://doi.org/10.5281/zenodo.48440',
                                            'identifierType' => 'DOI' }, { 'Identifier' => 'http://zenodo.org/record/48440', 'identifierType' => 'URL' }
                                        ])
      expect(subject.types).to eq('bibtex' => 'misc', 'citeproc' => 'other',
                                  'resourceType' => 'Software', 'resourceTypeGeneral' => 'Software', 'ris' => 'COMP', 'schemaOrg' => 'SoftwareSourceCode')
      expect(subject.creators).to eq([{ 'type' => 'Person', 'familyName' => 'Garza',
                                        'givenName' => 'Kristian', 'name' => 'Kristian Garza' }])
      expect(subject.titles).to eq([{ 'title' => 'Analysis Tools for Crossover Experiment of UI using Choice Architecture' }])
      expect(subject.descriptions.first['description']).to start_with('This tools are used to analyse the data produced by the Crosssover Experiment')
      expect(subject.dates).to eq('date' => '2016-03-27', 'dateType' => 'Issued')
      expect(subject.publication_year).to eq('2016')
    end

    it 'SoftwareSourceCode as string' do
      input = File.read("#{fixture_path}crosscite.json")
      subject = described_class.new(input: input)
      expect(subject.valid?).to be true
      expect(subject.identifiers).to eq([
                                          { 'Identifier' => 'https://doi.org/10.5281/zenodo.48440',
                                            'identifierType' => 'DOI' }, { 'Identifier' => 'http://zenodo.org/record/48440', 'identifierType' => 'URL' }
                                        ])
      expect(subject.types).to eq('bibtex' => 'misc', 'citeproc' => 'other',
                                  'resourceType' => 'Software', 'resourceTypeGeneral' => 'Software', 'ris' => 'COMP', 'schemaOrg' => 'SoftwareSourceCode')
      expect(subject.creators).to eq([{ 'type' => 'Person', 'familyName' => 'Garza',
                                        'givenName' => 'Kristian', 'name' => 'Kristian Garza' }])
      expect(subject.titles).to eq([{ 'title' => 'Analysis Tools for Crossover Experiment of UI using Choice Architecture' }])
      expect(subject.descriptions.first['description']).to start_with('This tools are used to analyse the data produced by the Crosssover Experiment')
      expect(subject.dates).to eq('date' => '2016-03-27', 'dateType' => 'Issued')
      expect(subject.publication_year).to eq('2016')
    end
  end
end
