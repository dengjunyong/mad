set -xe
rm -rf *.o
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  test.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  madplay.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  getopt.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  getopt1.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  version.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  resample.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  filter.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  tag.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  crc.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  rgain.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  player.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  audio.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  audio_aiff.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  audio_cdda.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  audio_hex.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  audio_null.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  audio_raw.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  audio_snd.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  audio_wave.c;
gcc -DHAVE_CONFIG_H -I. -DLOCALEDIR=\"/opt/madplay/share/locale\" -Wall -g -c  audio_alsa.c;
/bin/bash ./libtool --mode=link gcc  -Wall -march=i486 -g -O2   -o madplay madplay.o  getopt.o getopt1.o version.o resample.o filter.o tag.o crc.o rgain.o player.o audio.o audio_aiff.o audio_cdda.o audio_hex.o audio_null.o audio_raw.o audio_snd.o audio_wave.o audio_alsa.o -lasound -lmad -lid3tag -lm
/bin/bash ./libtool --mode=link gcc  -Wall -march=i486 -g -O2   -o test test.o getopt.o getopt1.o version.o resample.o filter.o tag.o crc.o rgain.o player.o audio.o audio_aiff.o audio_cdda.o audio_hex.o audio_null.o audio_raw.o audio_snd.o audio_wave.o audio_alsa.o -lasound -lmad -lid3tag -lm -lcurl
/bin/bash ./libtool --mode=link gcc  -Wall -march=i486 -g -O2 -shared  -o libmadplay.so getopt.o getopt1.o version.o resample.o filter.o tag.o crc.o rgain.o player.o audio.o audio_aiff.o audio_cdda.o audio_hex.o audio_null.o audio_raw.o audio_snd.o audio_wave.o audio_alsa.o -lasound -lmad -lid3tag -lm
gcc test.o -o test2 -L . -lcurl -lmadplay
