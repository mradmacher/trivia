require 'i18n'
require 'fileutils'

def get_tags
  tags = []
  while tag = gets
    break if tag.nil?
    tag = tag.chomp
    break if tag == ''
    tags << tag
  end
  tags
end

def get_options(tags)
  options = ['--preserve-modtime', '--remove-all-tags']
  tags.each do |tag|
    options << "--set-tag='#{tag}'"
  end
  options
end

def get_tag(name)
  tag = gets.chomp
  tag = nil if tag == '-'
  "#{name}=#{tag}" if !tag.nil?
end

def get_filename(tags)
  title = nil
  tracknumber = nil
  tags.each do |tag|
    _, title = tag.split('=') if tag.start_with?('TITLE')
    _, tracknumber = tag.split('=') if tag.start_with?('TRACKNUMBER')
  end
  filename = nil
  if title and tracknumber
    tracknumber = sprintf('%02d', tracknumber.to_i)
    title = I18n.transliterate(title)
    title.gsub!(/\W/, ' ')
    title.gsub!(/\s\s+/, ' ')
    title = title.downcase.tr(' ', '_')
    filename = "#{tracknumber}-#{title}"
  end
  filename
end



general = get_tags

Dir.glob('./*.flac').sort.each do |entry|
  track = []
  track << get_tag('TRACKNUMBER')
  track << get_tag('TITLE')
  track << get_tag('DESCRIPTION')
  track.concat(get_tags)
  track.compact!
  puts "No track tags for #{entry}" if track.empty?

  options = get_options(general + track)
  filename = get_filename(general + track)

  `metaflac #{options.join(' ')} #{entry}`
  FileUtils.mv(entry, "#{filename}.flac") if filename and !File.exists?("#{filename}.flac")
end

