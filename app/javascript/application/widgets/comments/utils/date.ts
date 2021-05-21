import moment from 'moment'

export function formatDate(dateOrString: Date|string, format = 'MMM D') {
  const now = moment();
  const date = typeof dateOrString === 'string' ? new Date(dateOrString) : dateOrString;
  const diffInHours = now.diff(date, 'hours');

  if (diffInHours < 24) {
    return moment(date).fromNow();
  }

  return moment(date).format(format);
}
