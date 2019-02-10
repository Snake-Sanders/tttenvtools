
require "fileutils"

def check_dir_exist(path, shall_create=false)
    dir_exist = Dir.exist?(path)
    puts "Checking directory: #{path} ...#{ dir_exist ? "exist" : "does not exist" }"

    if (not dir_exist) and shall_create then
        begin
            # creates the whole path if non existing
            FileUtils.mkdir_p(path)
            dir_exist = true
            puts "Created directory OK"
        rescue => exception
            puts "Error creating the directory."
            puts exception
        end
    end

    return dir_exist
end

def store_to_file( data, out_file )

    begin
        puts "Saving #{data.size} bytes in #{out_file}"
        file = nil

        if File.exist?(out_file) then
            file = File.open(out_file, 'w')
        else
            file = File.new(out_file, 'w')
        end

        file.write(data)
        puts "File saved"
    rescue IOError => e
        puts "Error: Fail to save."
        puts e
    ensure
        file.close unless file.nil?
    end
end

def copy_dir(src_dir, dst_dir)
    FileUtils.cp_r(src_dir, dst_dir, :verbose => true)
end

def del_dir(dir_path)
    begin
        if check_dir_exist(dir_path) then
            puts "Deleting directory: " + dir_path
            FileUtils.remove_dir(dir_path)
        end
    rescue => exception
        puts "Could not remove the directory:" + exception
    end
end