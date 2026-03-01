// ignore_for_file: directives_ordering
import '../lib/01_srp/bad.dart' as srp_bad;
import '../lib/01_srp/good.dart' as srp_good;
import '../lib/02_ocp/bad.dart' as ocp_bad;
import '../lib/02_ocp/good.dart' as ocp_good;
import '../lib/03_lsp/bad.dart' as lsp_bad;
import '../lib/03_lsp/good.dart' as lsp_good;
import '../lib/04_isp/bad.dart' as isp_bad;
import '../lib/04_isp/good.dart' as isp_good;
import '../lib/05_dip/bad.dart' as dip_bad;
import '../lib/05_dip/good.dart' as dip_good;

void main() {
  _section('S — Single Responsibility Principle');
  srp_bad.runBad();
  srp_good.runGood();

  _section('O — Open / Closed Principle');
  ocp_bad.runBad();
  ocp_good.runGood();

  _section('L — Liskov Substitution Principle');
  lsp_bad.runBad();
  lsp_good.runGood();

  _section('I — Interface Segregation Principle');
  isp_bad.runBad();
  isp_good.runGood();

  _section('D — Dependency Inversion Principle');
  dip_bad.runBad();
  dip_good.runGood();
}

void _section(String title) {
  print('\n${'=' * 60}');
  print('  $title');
  print('=' * 60);
}
