<?php
/**
 * @file
 * Views hook implementations for DG7.
 */

/**
* Implements hook_views_query_alter() for any "Collection" view.
*
* Lifted from http://blog.blenderbox.com/2011/11/03/how-to-modify-a-drupal-7-view-query-to-order-by-two-columns-simultaneously/
*
*/

function dg7_views_query_alter(&$view, &$query) {
  drupal_set_message(__FUNCTION__.' from /includes/views/dg7.views.inc called.', 'status');

  // If this is not a "collection" view... return unaltered.
  $viewName = $view->name;
  if ($viewName != "collection") { return; }

  // OK, we have a collection view.  Extract the collection ID from the $view query.
  $collection = $view->display_handler->handlers['argument'][ISLANDORA_ISMEMBEROFCOLLECTION_PREDICATE]->argument;
  list($junk,$cID) = explode('/',$collection);

  switch ($cID) {
    case 'grinnell:phpp':             // The Poweshiek History Preservation Project
    case 'grinnell:college-history':  // The Early College History collection
    case 'grinnell:jimmy-ley':        // The Jimmy Ley Collection
      $query->orderby = array( );
      break;

    case 'grinnell:faculty-scholarship':   // The Faculty Scholarship collection
    case 'grinnell:student-scholarship':   // The Student Scholarship collection
    case 'grinnell:curricular-materials':  // The Syllabi and Curricular Materials collection
    case 'grinnell:faulconer':             // The Faulconer Art collection
    case 'grinnell:faulconer-suppressed':
      $query->orderby = array( );
      break;

    default:   // Not entering a specialized collection.
      $query->orderby = array( );
      break;
  }

return;
}
