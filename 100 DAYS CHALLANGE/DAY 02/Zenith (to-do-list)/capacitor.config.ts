import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.productivity.todoapp',
  appName: 'Zenith',
  webDir: 'dist',
  plugins: {
    LocalNotifications: {
      smallIcon: 'ic_stat_zenith',
      iconColor: '#6366F1',
      sound: 'beep.wav',
    },
    StatusBar: {
      style: 'DARK',
      backgroundColor: '#09090B',
    },
    SplashScreen: {
      launchShowDuration: 1200,
      launchAutoHide: true,
      backgroundColor: '#09090B',
      androidSplashResourceName: 'splash',
      androidScaleType: 'CENTER_CROP',
      showSpinner: false,
    },
  },
  server: {
    androidScheme: 'https',
  },
};

export default config;
