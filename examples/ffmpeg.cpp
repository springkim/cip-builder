#include<iostream>
#ifdef __cplusplus
extern "C" {
#endif
#include<libavformat/avformat.h>
#include<libswscale/swscale.h>
#include<libavutil/imgutils.h>
#ifdef __cplusplus
}
#endif
int main() {
	const char* video_address = "rtsp://b1.dnsdojo.com:1935/live/sys2.stream";
	AVDictionary *dicts = NULL;
	av_dict_set(&dicts, "rtsp_transport", "tcp", 0);
	AVFormatContext* av_fmt_ctx = avformat_alloc_context();
	if (avformat_open_input(&av_fmt_ctx, video_address, NULL, &dicts) != 0) return 1;
	if (avformat_find_stream_info(av_fmt_ctx, NULL) < 0) return 1;
	AVStream* stream = NULL;
	for (unsigned int i = 0; i < av_fmt_ctx->nb_streams; i++) {
		if (av_fmt_ctx->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_VIDEO) {
			stream = av_fmt_ctx->streams[i];
			break;
		}
	}
	AVCodecContext* av_cdc_ctx = avcodec_alloc_context3(NULL);
	avcodec_parameters_to_context(av_cdc_ctx, stream->codecpar);
	//HW에 적합한 코덱을 자동으로 찾아 준다.
	AVCodec* av_cdc = avcodec_find_decoder(av_cdc_ctx->codec_id);
	avcodec_open2(av_cdc_ctx, av_cdc, NULL);
	AVPacket* av_pkt = av_packet_alloc();
	av_init_packet(av_pkt);
	AVFrame* av_frame = av_frame_alloc();

	while (1) {
		av_frame_unref(av_frame);
		int r = 0;
		do {
			do {
				av_packet_unref(av_pkt);
				r = av_read_frame(av_fmt_ctx, av_pkt);
			} while (av_pkt->stream_index != stream->index);
			avcodec_send_packet(av_cdc_ctx, av_pkt);
			r = avcodec_receive_frame(av_cdc_ctx, av_frame);
			av_packet_unref(av_pkt);
			if (r == AVERROR_EOF) goto EOV;
		} while (r != 0);
		std::cout << "(" << av_frame->width << "," << av_frame->height << ")" << std::endl;
	}
EOV:
	av_packet_unref(av_pkt);
	av_packet_free(&av_pkt);
	av_frame_free(&av_frame);
	avcodec_free_context(&av_cdc_ctx);
	avformat_free_context(av_fmt_ctx);
	av_dict_free(&dicts);
	return 0;
}