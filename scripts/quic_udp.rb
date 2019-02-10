require 'socket'

REQ_HELLO    = 0x6
REQ_DISCOVER = 0x1a
REQ_JOIN     = 0x14
REQ_AUTH     = 0x65
REQ_COMMAND  = 0x6a

ANS_HELLO     = 0x7
ANS_DISCOVER  = 0x1b
ANS_JOIN      = 0x15
ANS_AUTH      = 0x3e9
ANS_COMMAND   = 0x3ee


host_1_ip = 192.168.1.102
host_2_ip = 192.168.1.103

port = 80

MSG_NON_PUBLIC_PAYLOAD_OFFSET = 2
header 		= 0x00
package_nr 	= 0x00


# Header: 
MSG_PUBLIC_PAYLOAD_OFFSET = 18
# Where public flag is 0x5a:
# Version:No, Reset:Yes, CID:0x2,Packet #1, Multipath:Yes
public_flags 	= 0x5a
connection_id 	= 0xa5aa555aa5aa5500
tag 			= 0x00
tag_id 			= 0x00
padding 		= 0x00


checksum = 0x0000 # 32, 33

device_id = 0x0000 # 36 37 
command_id = 0x00 # 38 |  |send counter|   mac

# So we have “static” first 17 bytes header, then starting from byte 18 will come payload.

# Body:

u1 = UDPSocket.new
u1.bind("127.0.0.1", 4913)
u1.send "message-to-self", 0, "127.0.0.1", 4913
p u1.recvfrom(10) 