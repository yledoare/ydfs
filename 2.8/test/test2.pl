use SDL;
use SDL::RWOps;
use SDL::Image;
 
my $image = SDL::Image::load("test.png");

# print $image->w;

die SDL::get_error if (!$image);  
