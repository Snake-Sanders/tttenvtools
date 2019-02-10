
def check_dir_exist(path, shall_create=false)
    puts "Checking directory: " + path
    dir_exist = Dir.exist?(path)

    if (not dir_exist) and shall_create then
        begin
            Dir.mkdir(path)
            dir_exist = true
            puts "Created directory OK"
        rescue => exception
            puts "Error creating the directory."
            puts exception
        end
    end

    return dir_exist
end