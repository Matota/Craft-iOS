Pod::Spec.new do |s|

  s.name                = "ScoreAnalyser"
  s.version             = "1.0.0"
  s.summary             = "Library for Score analyser"
  s.description         = "this will add all the source files for analazing scores for craft work"
  s.homepage            = "http://craft.com"
  s.author              = "Hitesh Ahuja"
  s.platform            = :ios, "12.0"
  s.source_files        = "ScoreAnalyser"
  s.resources           = "ScoreAnalyser/*.xib"
  s.swift_version       = "4.2"
  s.source              = { :path => '.' }

end
