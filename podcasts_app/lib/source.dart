export 'package:flutter/material.dart';
export 'package:podcasts/themes/app_colors.dart';
export 'package:eva_icons_flutter/eva_icons_flutter.dart';
export 'package:ionicons/ionicons.dart';
export 'package:provider/provider.dart';
export 'package:podcasts/utils/utils.dart';
export 'package:podcasts/widgets/widgets_source.dart';
export 'package:podcasts/themes/app_icons.dart';
export 'dart:developer' show log;

import 'package:podcasts/models/series.dart';
import 'models/channel.dart';
import 'models/episode.dart';

final defaultEpisodeList = [
  const Episode(
      id: 1,
      image: firstImg,
      duration: 3641000,
      seriesName: 'Something Was Wrong',
      channel: 'Julia Cesar',
      title: 'There Were No Red Flags',
      audioUrl: firstUrl,
      description: firstDesc,
      episodeNumber: 10,
      date: 'Jun 2'),
  const Episode(
      id: 2,
      image: secondImg,
      duration: 361000,
      seriesName: 'Stolen: Search for Jermain',
      channel: 'Gimlet',
      title: 'The Dark Horse',
      audioUrl: secondUrl,
      description: secondDesc,
      episodeNumber: 02,
      date: 'Nov 5'),
  const Episode(
      id: 3,
      image: thirdImg,
      duration: 243000,
      seriesName: 'Business Wars',
      channel: 'Wondery',
      title: 'Introducing Who, When, WOW!',
      audioUrl: thirdUrl,
      description: thirdDesc,
      episodeNumber: 01,
      date: 'May 09'),
  const Episode(
      id: 4,
      image: fourthImg,
      duration: 295000,
      seriesName: 'Conspiracy Theories',
      channel: 'Parcast Network',
      title: 'Stolen Body Hypothesis',
      audioUrl: fourthUrl,
      description: fourthDesc,
      episodeNumber: 15,
      date: 'Jan 22'),
];

final seriesList = [
  Series(
      image: firstSeriesImage,
      name: 'The History of Christianity',
      description: firstSeriesDesc,
      channel: 'Bertie Pearson',
      episodeList: seriesEpisodeList),
  Series(
      image: secondSeriesImage,
      name: 'The Cut',
      description: secondSeriesDesc,
      channel: 'Vox Media Podcast Network',
      episodeList: seriesEpisodeList),
  Series(
      image: thirdSeriesImage,
      name: 'Philosophize This',
      description: thirdSeriesDesc,
      channel: 'Stephen West',
      episodeList: seriesEpisodeList),
  Series(
      image: fourthSeriesImage,
      name: 'Business Wars',
      description: fourthSeriesDesc,
      channel: 'Wondery',
      episodeList: seriesEpisodeList),
  Series(
      image: fifthSeriesImage,
      name: 'TANIS',
      description: fifthSeriesDesc,
      channel: 'Public Radio Alliance',
      episodeList: seriesEpisodeList)
];

final exampleSeries = Series(
    image: fifthSeriesImage,
    name: 'TANIS',
    description: fifthSeriesDesc,
    channel: 'Public Radio Alliance',
    episodeList: seriesEpisodeList);

final seriesEpisodeList = [
  const Episode(
      id: 5,
      image: firstSeriesImage,
      duration: 181000,
      seriesName: 'The History of Christianity',
      channel: 'Bertie Pearson',
      title: 'The origins of Christianity',
      audioUrl:
          'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/y2mate.com%20-%20The%20Lumineers%20%20BIG%20SHOT.mp3?alt=media&token=c1320aeb-99d9-427c-81c9-a96a53f56ea0',
      description: firstSeriesEpisodeDesc,
      episodeNumber: 1,
      date: 'Jan 22 2020'),
  const Episode(
      id: 6,
      image: firstSeriesImage,
      duration: 168000,
      seriesName: 'The History of Christianity',
      channel: 'Bertie Pearson',
      title: 'The New Testament',
      audioUrl:
          'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/Loyal%20Brave%20True.mp3?alt=media&token=a76baf09-6b16-4e73-8183-b92dbe7400ae',
      description: firstSeriesEpisodeDesc2,
      episodeNumber: 2,
      date: 'Feb 01 2020'),
  const Episode(
      id: 7,
      image: firstSeriesImage,
      duration: 241000,
      seriesName: 'The History of Christianity',
      channel: 'Bertie Pearson',
      title: 'The New Testament Part 2',
      audioUrl:
          'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/Adam%20Baldwin%20-%20Anytime.mp3?alt=media&token=8266fe85-a514-45d8-891c-cab170a5f52e',
      description: firstSeriesEpisodeDesc3,
      episodeNumber: 3,
      date: 'Feb 05 2020'),
  const Episode(
      id: 8,
      image: firstSeriesImage,
      duration: 283000,
      seriesName: 'The History of Christianity',
      channel: 'Bertie Pearson',
      title: 'Salvation',
      audioUrl:
          'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/casting_crowns_broken_together_official_music_video_mp3_23726.mp3?alt=media&token=c8856c1b-a3b4-4556-8ba8-87f5bdf4608e',
      description: firstSeriesEpisodeDesc4,
      episodeNumber: 4,
      date: 'Feb 12 2020')
];

const firstUrl =
    'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/y2mate.com%20-%20For%20Work%20%20Productive%20Chill%20Music%20Mix.mp3?alt=media&token=bae6b989-519e-4724-88e7-98359b22291f';
const secondUrl =
    'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/y2mate.com%20-%20You%20Will%20Be%20Found%20from%20the%20DEAR%20EVAN%20HANSEN%20Original%20Broadway%20Cast%20Recording.mp3?alt=media&token=b473e344-4370-4a98-94cb-e810727344eb';
const thirdUrl =
    'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/y2mate.com%20-%20Alicia%20Keys%20%20Perfect%20Way%20To%20Die%20Official%20Video.mp3?alt=media&token=9a8fdc59-e261-4505-938e-69d005bc7c96';
const fourthUrl =
    'https://firebasestorage.googleapis.com/v0/b/movie-recommendation-126.appspot.com/o/y2mate.com%20-%20Adele%20Hello%20lyrics.mp3?alt=media&token=44b0cdfe-ee8f-4fee-88ef-50e80d46fe83';

const firstDesc =
    'A widow begins to uncover her recently deceased husband\'s disturbing secrets.';
const secondDesc =
    'The podcast takes place over the course of a single morning in a 911 dispatch call center. Call operator Joe Baylor (Gyllenhaal) tries to save a caller in grave danger-but he soon discovers that nothing is as it seems, and facing the truth is the only way out.';
const thirdDesc =
    'A psychotic oil matriarch leaves the whole industry exposed when she attempts to outfight a bullish farmer whose water has been poisoned.';
const fourthDesc =
    'A 16-year-old girl returns home from camp and learns that her mother has a new boyfriend, one she intends to marry. A man whose charm, intelligence and beauty make him look like he\'s not human at all.';

const firstImg =
    'https://images.pexels.com/photos/4278784/pexels-photo-4278784.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const secondImg =
    'https://images.pexels.com/photos/5544036/pexels-photo-5544036.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const thirdImg =
    'https://images.pexels.com/photos/6357186/pexels-photo-6357186.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const fourthImg =
    'https://images.pexels.com/photos/7245371/pexels-photo-7245371.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

const firstSeriesImage =
    'https://images.pexels.com/photos/8335293/pexels-photo-8335293.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const secondSeriesImage =
    'https://images.pexels.com/photos/2690323/pexels-photo-2690323.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const thirdSeriesImage =
    'https://i.pinimg.com/564x/54/59/f8/5459f8ba13aa9c40dffdc31c0045f894.jpg';
const fourthSeriesImage =
    'https://images.pexels.com/photos/210600/pexels-photo-210600.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const fifthSeriesImage =
    'https://images.pexels.com/photos/2738919/pexels-photo-2738919.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

const firstSeriesDesc = 'A history of Christian Ideas.';
const secondSeriesDesc =
    'The Cut is a weekly audio magazine exploring culture, atyle, politics and more. New episodes every wednesday.';
const thirdSeriesDesc =
    'A podcast dedicated to ideas that shape our world. In chronological order, the thinkers and ideas that forged the world we live in are broken down and explaned.';
const fourthSeriesDesc =
    'Business is war. Netflix vs. HBO, Nike vs. Adidas. Sometimes the prize is your wallet or your attention. Sometimes it\'s just the fun of beating the other guy. The outcomes of these battles shapes what we buy and how we live.\nBusiness Wars gives you real stories of what drives great companies and their leaders.';
const fifthSeriesDesc =
    'In 2018, a young mother named Tanin Charlo left a bar in Missoula, Montana, and was never seen again. After two years and thousands of hours of investigative work,  police believe they are close to solving the mystery of what happenned to her. We go inside the investigation, tracking down leads and joining search parties. As we unravel this mystery, the show examines what it means to be an indigenous woman in America.';

const firstSeriesEpisodeDesc =
    'This was the exploration of the Jewish context into which Christianity was born. In this episode, we examine the four schools of the first century Judaism and how they impacted the early church.';
const firstSeriesEpisodeDesc2 =
    'This is a brief history of the New Testament exploring both the churched traditional dating and authorship of the revisions of the Historical-Critical Method.';
const firstSeriesEpisodeDesc3 =
    'In this episaode, we explore how the New Testament came together; why some books were in, some were out, and who chose whcih was which';
const firstSeriesEpisodeDesc4 =
    'Does the concept of salvation have any use if we don\'t see it as a ticket to some other worldly existence after we die? There are a few of the questions we tackle in this raw and powerful conversation with Mason Smith.';
const channelDesc = 'A good society is one with a proper balance between the aptitudes of ‘head’, ‘hand’ and ‘heart’. The modern knowledge economy, however, has delivered higher and higher returns to the cognitive elite and reduced the relative pay and status of manual and caring jobs.';

var defaultChannel = Channel(
    channelDescription: channelDesc,
    channelImage:
        'https://images.pexels.com/photos/3435323/pexels-photo-3435323.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    channelName: 'The Pearson Podcast',
    channelOwner: 'Betty Pearson',
    channelSeriesList: seriesList);


