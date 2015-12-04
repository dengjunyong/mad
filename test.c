/*
 * =====================================================================================
 *
 *       Filename:  test.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  11/30/2015 07:20:26 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *   Organization:  
 *
 * =====================================================================================
 */
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <curl/curl.h>
#include <curl/easy.h>
# include "gettext.h"

# include "version.h"
# include "audio.h"
# include "player.h"


//extern int play_one_buff(struct player *player, unsigned char const *buff, unsigned int buff_len);

static unsigned int recv_len = 0;
static unsigned char buff[2 * 1024 * 1024];

//可以采用POST或GET或其他的方式进行，下面以POST方式为例：
size_t write_data(void * ptr, size_t size, size_t nmemb, void * stream)
{
    memcpy(stream + recv_len, ptr, size * nmemb);
    recv_len += size * nmemb;
    //printf("write_data: size %d, nmemb %d, recv_len %d\n", size, nmemb, recv_len);
    return size * nmemb;
}

int main(int argc, char * argv[])
{
    CURL * curl;
    struct player player = {0};

    if (argc != 2){
        printf("argc must eq 2\n");
        return -1;
    }

    player_init(&player);
    //player.output.command = audio_alsa;
    player.output.command = audio_output(0);

    curl_global_init(CURL_GLOBAL_ALL);

    curl = curl_easy_init();

    char * data = "name=xxx";    // post到server的内容
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, data);  // 设置POST的方式
    curl_easy_setopt(curl, CURLOPT_URL, argv[1]);  // 设置server的URL

    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &buff);    // 设置write_data函数的最后一个参数的地址
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_data);  // 设置server的返回的数据的接收方式

    curl_easy_perform(curl);
    curl_easy_cleanup(curl);

    printf("\nrecv_len %d, buff : %s\n", recv_len, buff);
    FILE* fp = fopen("./tmp.mp3", "w+");
    fwrite(buff, 1, recv_len, fp);
    fclose(fp);

    play_one_buff(&player, buff, recv_len);

    return 0;
}
